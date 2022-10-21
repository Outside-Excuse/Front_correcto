//
//  ARView.swift
//  AppMaravillas
//
//  Created by Alejandro Hidalgo Badillo on 16/10/22.
//

import SwiftUI
import AVFoundation

struct ARView: View {
    let captureSession = AVCaptureSession()
    var body: some View {
        CameraView()
       
    }
}

struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView()
    }
}



struct CameraView : View {
    @StateObject var camera = CameraModel()
    var body: some View{
        ZStack{
            //Color.black
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            VStack{
                Spacer()
                if camera.isTaken{
                    Button(action: camera.retake, label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .foregroundColor(.black)
                            padding()
                            .background(Color.white)
                            .clipShape(Circle())
                    })
                    .padding(.trailing,10)
                }
                Spacer()
                HStack{
                    //si toma foto mostrar guardando y despues mostrar boton
                    if camera.isTaken{
                        Button(action:{if !camera.isSaved{camera.savePic()}}, label: {
                            Text(camera.isSaved ?"Saved" : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .clipShape(Capsule())
                        })
                        .padding(.leading)
                        Spacer()
                    }
                    else{
                        
                        Button(action: camera.takePic,label:{
                            ZStack{
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                Circle()
                                    .stroke(Color.white,lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                    } //fin del else
                }
                .frame(height: 75)
            }
        }
        .onAppear(perform: {
            camera.Check()
        })
    }
}

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    @Published var isTaken = false
    
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    @Published var output = AVCapturePhotoOutput()
    
    @Published var preview : AVCaptureVideoPreviewLayer!
    //pic data
    @Published var isSaved = false
    
    @Published var picData = Data(count: 0)
    
    func Check(){
        //first checking cameras got permision
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            SetUp()//setting up video
            return
        case .notDetermined:
            //vuelve a pedir permiso
            AVCaptureDevice.requestAccess(for: .video){
                (status) in
                if status{
                    self.SetUp()
                }
            }
        case.denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    func SetUp(){
        //setting Up Camera...
        
        do{
            //setting configs
            self.session.beginConfiguration()
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            
            let input = try AVCaptureDeviceInput(device: device!)
            
            //checking and adding to session...
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            //same for output...
            
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            self.session.commitConfiguration()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    //take and retake functions
    func takePic(){
        DispatchQueue.global(qos: .background).async {
            
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            DispatchQueue.main.async{
            withAnimation{self.isTaken.toggle()}
            }
        }
    }
    
    func retake(){
        DispatchQueue.global(qos: .background).async{
            self.session.startRunning()
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
                //clearing
                self.isSaved = false
            }
        }
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo:AVCapturePhoto, error: Error?) {
        if error != nil{
            return
        }
        print("pic taken...")
        
        guard let imageData = photo.fileDataRepresentation() else{return}
        self.picData = imageData;
    }
    
    func savePic(){
        let image = UIImage(data: self.picData)!
        
        //saving image
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.isSaved = true
        print("Saved Successfully....")
        
    }
}

//setting view for preview

struct CameraPreview: UIViewRepresentable{
    
    @ObservedObject var camera : CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view  = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        //your own properties...
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        camera.session.startRunning()
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {
    
    }
}
