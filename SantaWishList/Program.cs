using SantaWishList.Models;
using Microsoft.EntityFrameworkCore;


namespace SantaWishList
{
    public class Program
    {
        public static void Main(string[] args)
        {
            //test commit
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            builder.Services.AddCors(options => options.AddPolicy(name: "WishList",
    policy =>
    {
        policy.WithOrigins("http://localhost:4200").AllowAnyMethod().AllowAnyHeader();
    }));

            builder.Services.AddDbContext<ItemDbContext>(options =>
            options.UseSqlServer(builder.Configuration.GetConnectionString("ItemDbContext")));


            builder.Services.AddDbContext<UserDbContext>(options =>
            options.UseSqlServer(builder.Configuration.GetConnectionString("UserDbContext")));


            var app = builder.Build();


            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }
            app.UseCors("WishList");

            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();


            app.Run();


        }


    }
}