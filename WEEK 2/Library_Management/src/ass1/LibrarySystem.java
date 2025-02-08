package ass1;
import java.util.*;
abstract class LibrarySystem implements ILibrary {
    protected List<Book> books = new ArrayList<>();
    protected List<User> users = new ArrayList<>();

    public abstract void addBook(Book book);
    public abstract void addUser(User user);
}