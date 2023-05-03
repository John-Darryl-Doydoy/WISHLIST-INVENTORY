using Microsoft.EntityFrameworkCore;

namespace SantaWishList.Models
{
    public class UserDbContext : DbContext 
    {
        public UserDbContext(DbContextOptions<UserDbContext> options) : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog = SantaDB; Integrated Security=True;Connect Timeout=60;");
        }
    }

   
}
