import { useState } from "react";
import ProductCard from "../components/ProductCard";

const products = [
  { id: 1, name: "Laptop", price: 1000, category: "Electronics" },
  { id: 2, name: "Phone", price: 500, category: "Electronics" },
  { id: 3, name: "Smart Watch", price: 250, category: "Electronics" },
  { id: 4, name: "Mouse", price: 50, category: "Electronics" },
  { id: 5, name: "T-Shirt", price: 30, category: "Clothing" },
  { id: 6, name: "Jeans", price: 50, category: "Clothing" },
  { id: 7, name: "Jacket", price: 80, category: "Clothing" },
  { id: 8, name: "Saree", price: 120, category: "Clothing" },
  { id: 9, name: "Milk", price: 5, category: "Groceries" },
  { id: 10, name: "Bread", price: 3, category: "Groceries" },
  { id: 11, name: "Eggs", price: 4, category: "Groceries" },
  { id: 12, name: "Cheese", price: 7, category: "Groceries" }
];

function Home() {
  const [search, setSearch] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("All");

  const filteredProducts = products.filter(product => 
    product.name.toLowerCase().includes(search.toLowerCase()) && 
    (selectedCategory === "All" || product.category === selectedCategory)
  );

  return (
    <div className="max-w-6xl mx-auto p-8">
      <h1 className="text-5xl font-bold text-gray-900 mb-6 text-center italic text-purple-700">Our Featured Products</h1>
      <div className="flex flex-col md:flex-row justify-between mb-6">
        <input 
          type="text" 
          placeholder="Search products..." 
          className="w-full md:w-2/5 p-3 border rounded-lg shadow-md focus:ring focus:ring-purple-300"
          onChange={(e) => setSearch(e.target.value)}
        />
        <select 
          className="w-full md:w-2/5 p-3 border rounded-lg shadow-md bg-purple-100 hover:bg-purple-200 cursor-pointer" 
          onChange={(e) => setSelectedCategory(e.target.value)}
        >
          <option value="All">All Categories</option>
          <option value="Electronics">Electronics</option>
          <option value="Clothing">Clothing</option>
          <option value="Groceries">Groceries</option>
        </select>
      </div>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
        {filteredProducts.length > 0 ? (
          filteredProducts.map((product) => <ProductCard key={product.id} product={product} />)
        ) : (
          <p className="text-xl text-red-500 text-center">No products found.</p>
        )}
      </div>
    </div>
  );
}
export default Home;
