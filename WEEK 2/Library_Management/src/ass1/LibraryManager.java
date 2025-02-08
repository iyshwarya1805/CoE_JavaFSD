package ass1;

import java.io.*;
import java.util.*;

class LibraryManager extends LibrarySystem {
	private static final String FILE_NAME = "library.dat";

    public synchronized void borrowBook(String ISBN, String userID) throws BookNotFoundException, UserNotFoundException, MaxBooksAllowedException {
        Book book = books.stream().filter(b -> b.getISBN().equals(ISBN) && !b.isBorrowed()).findFirst().orElse(null);
        if (book == null) throw new BookNotFoundException("Book not available!");
        
        User user = users.stream().filter(u -> u.getUserID().equals(userID)).findFirst().orElse(null);
        if (user == null) throw new UserNotFoundException("User not found!");

        user.borrowBook(book);
        book.setBorrowed(true);
        System.out.println(user + " borrowed " + book);
    }

    public synchronized void returnBook(String ISBN, String userID) throws BookNotFoundException, UserNotFoundException {
        User user = users.stream().filter(u -> u.getUserID().equals(userID)).findFirst().orElse(null);
        if (user == null) throw new UserNotFoundException("User not found!");

        Book book = user.getBorrowedBooks().stream().filter(b -> b.getISBN().equals(ISBN)).findFirst().orElse(null);
        if (book == null) throw new BookNotFoundException("Book not found in user's borrowed list!");

        user.returnBook(book);
        book.setBorrowed(false);
        System.out.println(user + " returned " + book);
    }

    public Book searchBook(String title) {
        return books.stream().filter(b -> b.getTitle().toLowerCase().contains(title.toLowerCase())).findFirst().orElse(null);
    }

    public void reserveBook(String ISBN, String userID) throws BookNotFoundException, UserNotFoundException {
        Book book = books.stream().filter(b -> b.getISBN().equals(ISBN) && b.isBorrowed()).findFirst().orElse(null);
        if (book == null) throw new BookNotFoundException("Book is available! No need to reserve.");

        User user = users.stream().filter(u -> u.getUserID().equals(userID)).findFirst().orElse(null);
        if (user == null) throw new UserNotFoundException("User not found!");

        System.out.println(user + " has reserved " + book);
    }

    public void addBook(Book book) { books.add(book); }
    public void addUser(User user) { users.add(user); }

    // Save data to file
    public void saveData() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_NAME))) {
            oos.writeObject(books);
            oos.writeObject(users);
            System.out.println("Library data saved.");
        } catch (IOException e) {
            System.out.println("Error saving data: " + e.getMessage());
        }
    }

    // Load data from file
    public void loadData() {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_NAME))) {
            books = (List<Book>) ois.readObject();
            users = (List<User>) ois.readObject();
            System.out.println("Library data loaded.");
        } catch (IOException | ClassNotFoundException e) {
            System.out.println("No previous data found.");
        }
    }
}