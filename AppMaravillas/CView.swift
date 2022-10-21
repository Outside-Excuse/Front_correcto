//
//  CView.swift
//  AppMaravillas
//
//  Created by Carlos Milano on 20/10/22.
//

import SwiftUI
import AVFoundation


struct CView: View {
    var body: some View {
        CamaraView()
    }
}

struct CView_Previews: PreviewProvider {
    static var previews: some View {
        CView()
    }
}

struct CamaraView: View {
    
    @StateObject var camara = CamaraModel()
    
    var body: some View{
        ZStack{
            CamaraPreview(camara: camara)
                .ignoresSafeArea(.all, edges:  .all)
            
            VStack{
                
                if camara.isTaken{
                    
                    HStack{
                        
                        Spacer()
                        
                        Button(action: camara.reTake, label: {
                            
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                            
                        })
                        .padding(.trailing,10)
                    }
                }
                
                Spacer()
                
                HStack{
                    
                    if camara.isTaken{
                        
                        Button(action: {if !camara.isSaved{camara.savePic()}}, label: {
                            Text(camara.isSaved ? "Saved" : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .background(Color.white)
                                .clipShape(Capsule())
                                
                        })
                        .padding(.leading)
                        
                        Spacer()
                        
                        Button(action: camara.shareButton) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal,15)
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                    }
                    else{
                        Button(action: camara.takePic, label: {
                            
                            ZStack{
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 70, height: 70)
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                    }
                }
                .frame(height: 75)
            }
        }
        .onAppear(perform: {
            
            camara.Check()
            
        })
    }
}

class CamaraModel: NSObject,ObservableObject, AVCapturePhotoCaptureDelegate{
    
    @Published var isTaken = false
    
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    @Published var output = AVCapturePhotoOutput()
    
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    @Published var isSaved = false
    
    @Published var picData = Data(count: 0)
    
    func Check(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                
                if status{
                    self.setUp()
                }
                
            }
            
        case .denied:
            self.alert.toggle()
            return
            
        default:
            return
        }
    }
    
    func setUp(){
        
        do{
            self.session.beginConfiguration()
            
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            
            let input = try AVCaptureDeviceInput(device: device!)
            
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func takePic(){
        
        DispatchQueue.global(qos: .background).async {
            
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
            }
            
        }
        
    }
    
    func reTake(){
        
        DispatchQueue.global(qos: .background).async {
            
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
                
                self.isSaved = false
            }
            
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if error != nil{
            return
        }
        
        print("pic taken...")
        
        guard let imageData = photo.fileDataRepresentation() else{return}
        
        self.picData = imageData
    }
    
    func savePic(){
        
        let image = UIImage(data: self.picData)!
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        self.isSaved = true
        
        print("Saved")
        
    }
    
    func shareButton() {
            let url = URL(string: "https://designcode.io")
            let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)

            UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    
}

struct CamaraPreview: UIViewRepresentable {
    
    @ObservedObject var camara : CamaraModel
    
    func makeUIView(context: Context) ->  UIView {
        
        let view = UIView(frame: UIScreen.main.bounds)
        
        camara.preview = AVCaptureVideoPreviewLayer(session: camara.session)
        camara.preview.frame = view.frame
        
        camara.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camara.preview)
        
        camara.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
}
