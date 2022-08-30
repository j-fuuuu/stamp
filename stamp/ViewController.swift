//
//  ViewController.swift
//  stamp
//
//  Created by 藤井玖光 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationBarDelegate, UINavigationControllerDelegate {

    //スタンプ画像の名前が入った配列
    var imageNameArray: [String] = ["hana", "hoshi", "onpu", "shitumon"]
    
    //選択しているスタンプが画像の番号
    var ImageIndex: Int = 0
    
    //背景画像を表示させるImageView
    @IBOutlet var haikeiImageView: UIImageView!
    
    //スタンプ画像が入るImageView
    var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチされた位置を取得
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        
        //もしimageIndexが０でないとき
        if ImageIndex != 0{
            //スタンプサイズを40pxの正方形に指定
            ImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            
            //押されたスタンプの画像を設定
            let image: UIImage = UIImage(named: imageNameArray[ImageIndex - 1])!
            ImageView.image = image
            
            //タッチされた位置に画像をおく
            ImageView.center = CGPoint(x: location.x, y: location.y)
            
            //画像を表示する
            self.view.addSubview(ImageView)
        }
    }

    @IBAction func selectedFirst(){
        ImageIndex = 1
    }
    @IBAction func selectedSecond(){
        ImageIndex = 2
    }
    @IBAction func selectedThird(){
        ImageIndex = 3
    }
    @IBAction func selectedFourth(){
        ImageIndex = 4
    }
    
    @IBAction func back(){
        self.ImageView.removeFromSuperview()
    }
    

    @IBAction func selectBackground(){
        //UIimagePickerControllerのインスタンスを作る
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        //フォトライブラリを使う設定をする
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        //フォトライブラリを呼び出す
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //imageに選んだ画像を設定する
        let image = info[.originalImage]as? UIImage
        
        //imageを背景にする
        haikeiImageView.image = image
        
        //フォトライブラリを閉じる
        self.dismiss(animated:  true, completion: nil)
    }
    @IBAction func save(){
        //画面上のスクリーンショットを取得
        let rect:CGRect = CGRect(x: 0, y: 30, width: 320, height: 380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //フォトライブラリに保存
        UIImageWriteToSavedPhotosAlbum(capture!, nil, nil, nil)
    }
}

