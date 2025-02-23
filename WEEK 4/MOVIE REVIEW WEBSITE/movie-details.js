document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const movieTitle = urlParams.get('title'); 

    if (!movieTitle) {
        alert("Movie title is missing.");
        return;
    }

    fetch("movies.json")
        .then(response => response.json())
        .then(movies => {
            const movie = movies.find(m => m.title.toLowerCase() === movieTitle.toLowerCase());

            if (movie) {
                displayMovieDetails(movie);
            } else {
                document.getElementById("movie-details").innerHTML = "<p>Movie not found.</p>";
            }
        })
        .catch(error => console.error("Error loading movies:", error));
});

function displayMovieDetails(movie) {
    document.getElementById("movie-poster").src = movie.poster;
    document.getElementById("movie-title").textContent = `${movie.title} (${movie.year})`;
    document.getElementById("movie-director").textContent = movie.director;
    document.getElementById("movie-storyline").textContent = movie.storyline;
}
