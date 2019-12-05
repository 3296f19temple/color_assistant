//
//  OutputVC.swift
//  ColorAssistant
//
//  Created by Likhon Gomes on 11/22/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import UIKit
import WebKit

class OutputVC: UIViewController {

    let captureImageView = UIImageView()
    var outputImage = UIImage()
    let cardView = UIView()
    let dismissButton = UIButton()
    let wheel = WKWebView()
    var img = #imageLiteral(resourceName: "stacked")
    let colorLabel = UILabel()
    let copyButton = UIButton()
    let colorView = UIView()
    let colorWheelEnvelop = UIView()
    let colorNameLabel = UILabel()
    let colorDetails = UIView()
    let saveButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //captureImageViewSetup()
        cardViewSetup()
        colorWheelEnvelopSetup()
        colorWheel(outputImage)
        colorViewSetup()
        colorDetailsSetup()
        copyButtonSetup()
        colorLabelSetup()
        colorNameLabelSetup()
        saveButtonSetup()
        dismissButtonSetup()
    }
    
    func saveButtonSetup(){
        cardView.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        saveButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.4705882353, blue: 0.4509803922, alpha: 1)
        saveButton.layer.cornerRadius = 10
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    @objc func saveButtonClicked(){
        saveButton.backgroundColor = #colorLiteral(red: 0.568627451, green: 0.7411764706, blue: 0.2274509804, alpha: 1)
        saveButton.setTitle("Saved", for: .normal)
        UIImageWriteToSavedPhotosAlbum(outputImage, nil, nil, nil);
    }
    
    func colorDetailsSetup() {
        cardView.addSubview(colorDetails)
        colorDetails.translatesAutoresizingMaskIntoConstraints = false
        colorDetails.topAnchor.constraint(equalTo: colorView.bottomAnchor).isActive = true
        colorDetails.leadingAnchor.constraint(equalTo: colorWheelEnvelop.trailingAnchor, constant: 10).isActive = true
        colorDetails.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        colorDetails.bottomAnchor.constraint(equalTo: colorWheelEnvelop.bottomAnchor).isActive = true
        //colorDetails.backgroundColor = outputImage.getCenterColor()
        let red = UILabel()
        let green = UILabel()
        let blue = UILabel()
        
        let centX = (outputImage.size.width/2) - 10
        let centY = (outputImage.size.height/2) - 10
        let centerColor = outputImage.averageColor(xCoord: Int(centX), yCoord: Int(centY))
        let breakColorComp = centerColor!.cgColor.components //need to break into array
        let r = breakColorComp![0]//red
        let g = breakColorComp![1]//green
        let b = breakColorComp![2]//blue
        
        colorDetails.addSubview(red)
        red.translatesAutoresizingMaskIntoConstraints = false
        red.centerXAnchor.constraint(equalTo: colorDetails.centerXAnchor).isActive = true
        red.topAnchor.constraint(equalTo: colorDetails.topAnchor, constant: 10).isActive = true
        red.text = "Red \(Int(r*255))"
        red.textColor = .black
        
        colorDetails.addSubview(green)
        green.translatesAutoresizingMaskIntoConstraints = false
        green.topAnchor.constraint(equalTo: red.bottomAnchor, constant: 10).isActive = true
        green.centerXAnchor.constraint(equalTo: colorDetails.centerXAnchor).isActive = true
        green.text = "Green \(Int(g*255))"
        green.textColor = .black
        
        colorDetails.addSubview(blue)
        blue.translatesAutoresizingMaskIntoConstraints = false
        blue.topAnchor.constraint(equalTo: green.bottomAnchor, constant: 10).isActive = true
        blue.centerXAnchor.constraint(equalTo: colorDetails.centerXAnchor).isActive = true
        blue.text = "Blue \(Int(b*255))"
        blue.textColor = .black
        
    }
    
    
    func colorNameLabelSetup(){
        cardView.addSubview(colorNameLabel)
        colorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        colorNameLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        //colorNameLabel.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor).isActive = true
        colorNameLabel.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 2).isActive = true
        colorNameLabel.text = "Color Name"
        colorNameLabel.font = UIFont.systemFont(ofSize: 20)
        colorNameLabel.textColor = #colorLiteral(red: 0.2470588235, green: 0.3019607843, blue: 0.4431372549, alpha: 1)
    }
    
    func colorViewSetup() {
        cardView.addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.topAnchor.constraint(equalTo: colorWheelEnvelop.topAnchor).isActive = true
        colorView.leadingAnchor.constraint(equalTo: colorWheelEnvelop.trailingAnchor, constant: 10).isActive = true
        colorView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        colorView.heightAnchor.constraint(equalTo: colorView.widthAnchor, multiplier: 1) .isActive = true
        colorView.layer.cornerRadius = colorView.bounds.width
        colorView.layer.masksToBounds = true
        let centX = (outputImage.size.width/2) - 15
        let centY = (outputImage.size.height/2) - 15
        let centerColor = outputImage.averageColor(xCoord: Int(centX), yCoord: Int(centY))
        colorView.backgroundColor = centerColor
    }
    
    func copyButtonSetup() {
        cardView.addSubview(copyButton)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        copyButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
        copyButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        copyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        copyButton.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.4705882353, blue: 0.4509803922, alpha: 1)
        copyButton.layer.cornerRadius = 10
        copyButton.setTitle("Copy", for: .normal)
        copyButton.addTarget(self, action: #selector(copyButtonClicked), for: .touchUpInside)
    }
    
    @objc func copyButtonClicked(){
        copyButton.backgroundColor = #colorLiteral(red: 0.568627451, green: 0.7411764706, blue: 0.2274509804, alpha: 1)
        copyButton.setTitle("Copied", for: .normal)
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = "\(colorLabel.text!)"
    }

    
    func colorLabelSetup() {
        cardView.addSubview(colorLabel)
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        //colorLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        colorLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        colorLabel.centerYAnchor.constraint(equalTo: copyButton.centerYAnchor).isActive = true
        colorLabel.text = "nil"
        colorLabel.textColor = #colorLiteral(red: 0.2470588235, green: 0.3019607843, blue: 0.4431372549, alpha: 1)
        colorLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    func colorWheelEnvelopSetup() {
        cardView.addSubview(colorWheelEnvelop)
        colorWheelEnvelop.translatesAutoresizingMaskIntoConstraints = false
        colorWheelEnvelop.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20).isActive = true
        colorWheelEnvelop.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        colorWheelEnvelop.heightAnchor.constraint(equalToConstant: 250).isActive = true
        colorWheelEnvelop.widthAnchor.constraint(equalToConstant: 250).isActive = true
        wheel.backgroundColor = .clear
    }
    
    func setupColorWheel(HTML:String) {
        colorWheelEnvelop.addSubview(wheel)
        wheel.translatesAutoresizingMaskIntoConstraints = false
        wheel.bottomAnchor.constraint(equalTo: colorWheelEnvelop.bottomAnchor).isActive = true
        wheel.leadingAnchor.constraint(equalTo: colorWheelEnvelop.leadingAnchor).isActive = true
        //wheel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        //wheel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        //wheel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        wheel.heightAnchor.constraint(equalToConstant: 250).isActive = true
        wheel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        wheel.scrollView.isScrollEnabled = false
        wheel.loadHTMLString(HTML, baseURL: nil)
        //wheel.frame = wheelsize
        wheel.center = cardView.center
        wheel.backgroundColor = .clear
        wheel.isOpaque = true
    }
    
    func captureImageViewSetup() {
        view.addSubview(captureImageView)
        captureImageView.translatesAutoresizingMaskIntoConstraints = false
        captureImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        captureImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        captureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        captureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        captureImageView.image = outputImage
    }
    
    func cardViewSetup() {
        view.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45).isActive = true
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
    }
    
    func dismissButtonSetup() {
        view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
    }
    
    @objc func dismissButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

    
    fileprivate func colorWheel(_ image: UIImage) {
        let centX = image.size.width/2 - 10
        let centY = image.size.height/2 - 10
        let centerColor = image.averageColor(xCoord: Int(centX), yCoord: Int(centY))
        let breakColorComp = centerColor!.cgColor.components //need to break into array
        let r = breakColorComp![0]//red
        let g = breakColorComp![1]//green
        let b = breakColorComp![2]//blue
        DispatchQueue.main.async {
            //self.view.backgroundColor = centerColor
            self.setupColorWheel(HTML: self.wheelSetValue(r: r, g: g, b: b))//color wheel added to screen
            self.colorLabel.text = centerColor!.hexString
            self.colorNameLabel.text = centerColor!.name(red: r * 255, green: g * 255, blue: b * 255)
        }
    }
    
    func wheelSetValue(r:CGFloat,g:CGFloat,b:CGFloat) -> String {
        let HTML = """
        <div class="outer"><div class="overlay"></div><div class="color-space"></div></div><style>.overlay { height: 100%; width: 100%; position: absolute;}</style>
        <script>function ColorPicker(element) {
            this.element = element;

            this.init = function() {
                var diameter = this.element.offsetWidth;

                var canvas = document.createElement('canvas');
                canvas.height = diameter;
                canvas.width = diameter,
                this.canvas = canvas;

                this.renderColorMap();

                element.appendChild(canvas);

                this.setupBindings();
            };

            this.renderColorMap = function() {
                var canvas = this.canvas;
                var ctx = canvas.getContext('2d');

                var radius = canvas.width / 2;
                var toRad = (2 * Math.PI) / 360;
                var step = 1 / radius;

                ctx.clearRect(0, 0, canvas.width, canvas.height);

                var cx = cy = radius;
                for(var i = 0; i < 360; i += step) {
                    var rad = i * toRad;
                    var x = radius * Math.cos(rad),
                        y = radius * Math.sin(rad);

                    ctx.strokeStyle = 'hsl(' + i + ', 100%, 50%)';

                    ctx.beginPath();
                    ctx.moveTo(radius, radius);
                    ctx.lineTo(cx + x, cy + y);
                    ctx.stroke();
                }

                        // draw saturation gradient
                var grd = ctx.createRadialGradient(cx,cy,0,cx,cx,radius);
                grd.addColorStop(0,"white");
                      grd.addColorStop(1,'rgba(255, 255, 255, 0)');
                ctx.fillStyle = grd;
                //ctx.fillStyle = 'rgb(255, 255, 255)';
                ctx.beginPath();
                ctx.arc(cx, cy, radius, 0, Math.PI * 2, true);
                ctx.closePath();
                ctx.fill();

                // render the rainbow box here ----------
            };

            this.renderMouseCircle = function(x, y) {
                var canvas = this.canvas;
                var ctx = canvas.getContext('2d');

                ctx.strokeStyle = 'rgb(255, 255, 255)';
                ctx.fillStyle = 'rgba(0, 0, 0, 0.5)'
                ctx.lineWidth = '3';
                ctx.beginPath();
                ctx.arc(x, y, 10, 0, Math.PI * 2, true);
                ctx.closePath();
                ctx.fill();
                ctx.stroke();
            };

            this.setupBindings = function() {
                var canvas = this.canvas;
                var ctx = canvas.getContext('2d');
                var self = this;

                canvas.addEventListener('click', function(e) {
                    var x = e.offsetX || e.clientX - this.offsetLeft;
                    var y = e.offsetY || e.clientY - this.offsetTop;

                    var imgData = ctx.getImageData(x, y, 1, 1).data;
                    //var selectedColor = new Color(imgData[0], imgData[1], imgData[2]);
                    // do something with this

                    self.renderMouseCircle(x, y);
                }, false);
            };

            function rgbToHsv(r, g, b){
                r = r/255, g = g/255, b = b/255;
                var max = Math.max(r, g, b), min = Math.min(r, g, b);
                var h, s, v = max;

                var d = max - min;
                s = max == 0 ? 0 : d / max;

                if(max == min){
                    h = 0; // achromatic
                }else{
                    switch(max){
                        case r: h = (g - b) / d + (g < b ? 6 : 0); break;
                        case g: h = (b - r) / d + 2; break;
                        case b: h = (r - g) / d + 4; break;
                    }
                    h /= 6;
                }

                return [h, s, v];
            }

            this.plotRgb = function(r, g, b) {
                    var canvas = this.canvas;
                var ctx = canvas.getContext('2d');

                var [h, s, v] = rgbToHsv(r, g, b);
                var theta = h * 2 * Math.PI;
                var maxRadius = canvas.width / 2;
                var r = s * maxRadius;
                var x = r * Math.cos(theta) + maxRadius,
                    y = r * Math.sin(theta) + maxRadius;
                this.renderMouseCircle(x, y);
            }

            this.init();
        }

        var pick = new ColorPicker(document.querySelector('.color-space'));

        var RGBList = [
            {'r':\(r*255),'g':\(g*255),'b':\(b*255)}
        ];

        RGBList.forEach(function (color) {
            pick.plotRgb(color.r, color.g, color.b);
        })
        </script>
        """
        return HTML
    }
    
}
