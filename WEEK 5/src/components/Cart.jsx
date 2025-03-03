import { useCart } from "../context/CartContext";

function Cart() {
  const { cart, dispatch } = useCart();

  return (
    <div className="max-w-2xl mx-auto p-6">
      <h2 className="text-3xl font-bold text-gray-800">Shopping Cart</h2>

      {cart.length === 0 ? (
        <p className="text-gray-500 mt-4">Your cart is empty.</p>
      ) : (
        <div className="space-y-4 mt-4">
          {cart.map((item) => (
            <div key={item.id} className="flex justify-between items-center p-4 border rounded-lg shadow-md bg-white">
              <div>
                <h3 className="text-lg font-semibold">{item.name}</h3>
                <p className="text-gray-600">${item.price}</p>
              </div>
              <button
                className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition"
                onClick={() => dispatch({ type: "REMOVE_FROM_CART", payload: item.id })}
              >
                Remove
              </button>
            </div>
          ))}
          <p className="text-xl font-semibold mt-4">Total: <span className="text-green-600">${cart.reduce((sum, item) => sum + item.price, 0)}</span></p>

          <button
            className="bg-gray-700 text-white px-6 py-2 rounded mt-4 hover:bg-gray-800 transition"
            onClick={() => dispatch({ type: "CLEAR_CART" })}
          >
            Clear Cart
          </button>
        </div>
      )}
    </div>
  );
}

export default Cart;
