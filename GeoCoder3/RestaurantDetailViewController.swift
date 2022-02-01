//
//  RestaurantDetailViewController.swift
//  GeoCoder
//
//  Created by Sie monyan on 2021/12/1.
//

import UIKit
import SwiftUI
class RestaurantDetailViewController: UITableViewCell {

    
    
    
    
    
    
    
    @IBOutlet var restaurantImageView:UIImageView!
    var restaurantImageName = ""
  @State var restaurants:[Restaurant] = [
    Restaurant(name: "Cafe Deadend", type: "Coffee & Tea shop", location: "G/F.72 Po Hing Fong,Sheung Wan,Hong Kong", image: "", isVisited: true),
       
    Restaurant(name: "CASK Pub and Kitchen", type: "Coffee & Tea shop", location: "G/F.72 Po Hing Fong,Sheung Wan,Hong Kong", image: "", isVisited: true)
        
    ]
    
     func viewDidLoad(){
        
        restaurantImageView.image = UIImage(named:restaurantImageName)
        
    }
    
    func prepare(for seque:UIStoryboardSegue,sender:Any?){
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 4
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantDetailTableView
           
                    
                    cell.backgroundColor = UIColor.clear
                    
                    return cell
                }
         
            
         
        }

struct restaurant:Identifiable{
    var id: ObjectIdentifier
    
    var name :String
    var type:String
    var location:String
    var isFavorite: Bool = false
    
}
struct RestaurantDetailView{
  
    
    var restaurant:Restaurant
    
    var body:some View{
        VStack{
            Image(restaurant.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(restaurant.name)
                .font(.system(.title,design:.rounded))
                .fontWeight(.black)
            
            Spacer()
        }
    }

    
}

struct BasicImageRow:View{
    var restaurant:Restaurant
    
    var body: some View{
        
        HStack{
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
            Text(restaurant.name)
            Image(systemName: "start.fill")
                .foregroundColor(.yellow)
            
            BasicImageRow(restaurant: restaurant)
                .contextMenu{
                    Button(action:{
                        
                    }
                    ){
                        HStack{
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                        
                    }
                    Button(action:{
                        
                    }){
                        HStack{
                            Text("Favorite")
                            Image(systemName: "star")
                        }
                        
                    }
                    
                    
                    
                }
            
               
        }

      
        
    }

}

    
    
    
    



