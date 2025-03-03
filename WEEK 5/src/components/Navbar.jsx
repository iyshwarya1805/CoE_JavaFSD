import { Link } from "react-router-dom";

function Navbar() {
  return (
    <nav className="bg-gradient-to-r from-pink-500 to-purple-700 p-6 text-white flex justify-between items-center shadow-xl text-lg font-semibold uppercase tracking-wider border-b-4 border-indigo-400">
      <h1 className="text-4xl font-bold italic tracking-widest text-yellow-300">Quick pick</h1>
      <div className="flex space-x-10">
        <Link to="/" className="hover:text-yellow-300 transform hover:scale-110 transition duration-300">Home</Link>
        <Link to="/cart" className="hover:text-yellow-300 transform hover:scale-110 transition duration-300">Cart</Link>
      </div>
    </nav>
  );
}
export default Navbar;
