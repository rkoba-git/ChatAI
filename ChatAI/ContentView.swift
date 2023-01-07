
import SwiftUI

struct ContentView: View{
    
    @StateObject private var appHideControl = AppHideControl.shared
    
    var body: some View {
        ZStack {
            //.ignoresSafeArea(.keyboard, edges: .bottom)によってキーボードによる隠れを回避
            AIView().ignoresSafeArea(.keyboard, edges: .bottom)
            LoadingView().zIndex(appHideControl.zIndex)
        }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Now Loading...")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.386, green: 0.849, blue: 0.881).opacity(0.6))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}

struct AIView: View {
    //@Stateを使用することで，その変数が変わるたびにpreview側も変化する
    @State private var text = ""
    @State private var answer = ""
       
    
    var body: some View {
        VStack {
            Text("Question to AI")
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .padding()
            
            TextField("質問", text: $text,
                      onCommit: {
                print("打ち込み終了")
                AppHideControl.shared.showLoading()
                APICaller.shared.getResponse(input: text) { result in
                    switch result{
                    case .success(let output):
                        DispatchQueue.main.async {
                            AppHideControl.shared.hideLoading()
                        }
                        answer = output
                        print("解答の取得に成功")
                    default:
                        DispatchQueue.main.async {
                            AppHideControl.shared.hideLoading()
                        }
                        print("AIの解答の取得に失敗")
                    }
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            // ドル記号($)は，状態変数(@Stateを付与した変数)の参照を渡す役割
            //参照したい状態変数名の前に$をつけることで使用することができる
            Text("AI's answer")
                .fontWeight(.black)
                .multilineTextAlignment(.center)
            Text(answer)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
            Spacer()
            Image("AIimage") //svgファイルなら背景透過可能
                .resizable()
                .scaledToFit()
                .frame(width: 300.0, height: 120.0)
        }.background(Color(hue: 0.512, saturation: 0.565, brightness: 0.884))
    }
}
