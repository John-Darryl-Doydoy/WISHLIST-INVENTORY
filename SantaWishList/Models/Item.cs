using System.ComponentModel.DataAnnotations;

namespace SantaWishList.Models
{
    public class Item
    {
        [Key]
        public int Id { get; set; }
        public string name { get; set; }
        public string receiver { get; set; }
        public string brand { get; set; }
        public int price { get; set; }
      

        public string image { get; set; }
    }
}
