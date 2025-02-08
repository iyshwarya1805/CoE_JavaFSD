package ass1;
import java.util.*;
import java.io.*;
class User implements Serializable {
    private String name;
    private String userID;
    private List<Book> borrowedBooks;

    public User(String name, String userID) {
        this.name = name;
        this.userID = userID;
        this.borrowedBooks = new ArrayList<>();
    }

    public String getUserID() { return userID; }
    public List<Book> getBorrowedBooks() { return borrowedBooks; }

    public void borrowBook(Book book) throws MaxBooksAllowedException {
        if (borrowedBooks.size() >= 3) {
            throw new MaxBooksAllowedException("Maximum 3 books can be borrowed!");
        }
        borrowedBooks.add(book);
    }

    public void returnBook(Book book) {
        borrowedBooks.remove(book);
    }

    @Override
    public String toString() {
        return name + " (ID: " + userID + ")";
    }
}
    
    