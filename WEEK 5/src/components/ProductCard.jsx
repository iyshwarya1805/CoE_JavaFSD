import { useCart } from "../context/CartContext";
import { useState } from "react";

function ProductCard({ product }) {
  const { dispatch } = useCart();
  const [added, setAdded] = useState(false);

  const handleAddToCart = () => {
    dispatch({ type: "ADD_TO_CART", payload: product });
    setAdded(true);
    setTimeout(() => setAdded(false), 2000); 
  };

  return (
    <div className="border p-6 rounded-lg shadow-xl bg-white hover:shadow-2xl transition duration-300 text-center transform hover:scale-105 flex flex-col items-center">
      <h2 className="text-2xl font-semibold text-gray-800">{product.name}</h2>
      <p className="text-gray-600 text-lg font-bold">${product.price}</p>
      <button 
        className="bg-green-500 text-white px-6 py-2 mt-4 rounded-lg hover:bg-green-600 transition duration-300 transform hover:scale-110 shadow-md"
        onClick={handleAddToCart}
      >
        Add to Cart
      </button>
      {added && <p className="text-green-600 mt-2">✔ Product added to cart!</p>}
    </div>
  );
}
export default ProductCard;
