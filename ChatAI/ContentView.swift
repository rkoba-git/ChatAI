
import SwiftUI

struct ContentView: View{
    @State private var text = "" //@Stateを使用することで，その変数が変わるたびにpreview側も変化する
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
                APICaller.shared.getResponse(input: text) { result in
                    switch result{
                    case .success(let output):
                        answer = output
                        print("解答の取得に成功")
                    default:
                        print("AIの解答の取得に失敗")
                    }
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            // ドル記号($)は，状態変数(@Stateを付与した変数)の参照を渡す役割
            //参照したい状態変数名の前に$をつけることで使用することができる
            Text("AI's answer\n\(answer)")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
