import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  ItemArray : any[] = [];
  isResultLoaded = false;
  isUpdateFormActive = false;
 
  item_name: string ="";
  item_receiver: string ="";

  item_brand: string ="";
  item_price= "";

  item_image: string ="";
  item_currentID = "";
  
  totalPrice = 0;

  constructor(private http: HttpClient )
  {
    this.getAllItem();
  }
 
  ngOnInit(): void {
  }
 
  getAllItem()
  {
    this.http.get("https://localhost:44340/api/Item/Get")
    .subscribe((resultData: any)=>
    {
        this.isResultLoaded = true;
        console.log(resultData);
        this.ItemArray = resultData;

        let holder = 0;
        for(let i = 0; i < this.ItemArray.length; i++){
            holder += this.ItemArray[i].price;
        }
        this.totalPrice = holder;

    });
  }
 
  register()
  {
    const filePath = this.item_image;
    const fileName = filePath?.split('\\').pop() || '';

    let bodyData = {
      "name" : this.item_name,
      "receiver" : this.item_name,
      "brand" : this.item_brand,
      "price": this.item_price,
      "image": fileName
    
    };
 
    this.http.post("https://localhost:44340/api/Item/Add",bodyData).subscribe((resultData: any)=>
    {
        console.log(resultData);
        this.clearForm();
        this.getAllItem();
    
    });
  }
 
  setUpdate(data: any)
  {
   this.item_name= data.name;
   this.item_brand = data.brand;
  this.item_price = data.price;
  this.item_receiver = data.receiver;
   this.item_currentID= data.id;
   this.item_image =data.image;
   
  }
 
  UpdateRecords()
  {

    const filePath = this.item_image;
    console.log(filePath);
    const fileName = filePath?.split('\\').pop() || '';

    let bodyData =
    {
      "id":this.item_currentID,
      "name" : this.item_name,
      "brand" : this.item_brand,
      "price":this.item_price,
      "receiver":this.item_receiver,
      "image":fileName
    };
    
    this.http.patch("https://localhost:44340/api/Item/Update"+ "/"+ this.item_currentID,bodyData).subscribe((resultData: any)=>
    {
        console.log(resultData);
this.clearForm();
        this.getAllItem();
    
    });
  }
  save()
  {
    if(this.item_currentID == '')
    {
        this.register();
    }
      else
      {
       this.UpdateRecords();
      }      
 
  }

  clearForm(){
    this.item_name = '';
    this.item_brand = '';
    this.item_price = '';
    this.item_receiver = '';
    this.item_image = '';
     this.item_currentID = '';
  }
 
 
  setDelete(data: any)
  {
    this.http.delete("https://localhost:44340/api/Item/Delete"+ "/"+ data.id).subscribe((resultData: any)=>
    {
        this.getAllItem();
    });
  }
}
