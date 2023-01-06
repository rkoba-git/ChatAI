
import OpenAISwift
import Foundation

final class APICaller{
    static let shared = APICaller()
    
    @frozen enum Constants{ //structではストアドプロパティ、enumではcaseの追加、削除、並び替えを制限する
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    
    private init(){}
    
    public func setup(){
        self.client = OpenAISwift(authToken: Constants.key)
    }

    public func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void){
        client?.sendCompletion(with: input, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output =  model.choices.first?.text ?? "解答なし" //??の後がデフォルトの値になる
                print(output)
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
