document.addEventListener("DOMContentLoaded", function () {
    fetch("movies.json")
        .then(response => response.json())
        .then(movies => {
            console.log("Movies loaded:", movies);
            const path = window.location.pathname;

            if (path.includes("index.html")) {
                displayMovies(movies);
            } else if (path.includes("search.html")) {
                setupSearch(movies);
            } else if (path.includes("reviews.html")) {
                setupReviews(movies);
            }
        })
        .catch(error => console.error("Error loading movies:", error));
});

function displayMovies(movies) {
    const moviesContainer = document.getElementById("movies-container");
    moviesContainer.innerHTML = "";
    
    movies.forEach(movie => {
        const movieCard = document.createElement("div");
        movieCard.classList.add("movie-card");

        movieCard.innerHTML = `
            <img src="${movie.poster}" alt="${movie.title}" onerror="this.onerror=null; this.src='images/default.jpg';">
            <h3><a href="movie-details.html?id=${movie.id}">${movie.title} (${movie.year})</a></h3>
        `;

        moviesContainer.appendChild(movieCard);
    });
}

function setupSearch(movies) {
    const searchDropdown = document.getElementById("search-dropdown");
    const searchButton = document.getElementById("search-button");
    const movieDetails = document.getElementById("movie-details");
    const reviewsContainer = document.getElementById("reviews-container");

    movies.forEach(movie => {
        const option = document.createElement("option");
        option.value = movie.title;
        option.textContent = movie.title;
        searchDropdown.appendChild(option);
    });

    searchButton.addEventListener("click", function () {
        const selectedMovieTitle = searchDropdown.value;

        if (!selectedMovieTitle) {
            alert("Please select a movie!");
            return;
        }

        const movie = movies.find(m => m.title === selectedMovieTitle);

        if (movie) {
            movieDetails.innerHTML = `
                <img src="${movie.poster}" alt="${movie.title}" onerror="this.onerror=null; this.src='images/default.jpg';">
                <h2>${movie.title} (${movie.year})</h2>
                <p><strong>Director:</strong> ${movie.director}</p>
                <p><strong>Storyline:</strong> ${movie.storyline}</p>
            `;
            displayReviews(selectedMovieTitle);
        } else {
            movieDetails.innerHTML = "<p>Movie not found.</p>";
            reviewsContainer.innerHTML = "";
        }
    });
}

function displayReviews(movieTitle) {
    const reviewsContainer = document.getElementById("reviews-container");
    reviewsContainer.innerHTML = "<h3>Reviews:</h3>";
    const reviews = JSON.parse(localStorage.getItem(movieTitle)) || [];

    if (reviews.length === 0) {
        reviewsContainer.innerHTML += "<p>No reviews yet. Be the first to review this movie!</p>";
        return;
    }

    reviews.forEach(review => {
        const reviewItem = document.createElement("div");
        reviewItem.classList.add("review-item");

        const formattedDate = new Date(review.timestamp).toLocaleString(); 

        reviewItem.innerHTML = `
            <p>👉 <strong>${review.name}</strong> rated ${"⭐".repeat(review.rating)} 
            and wrote: "${review.text}"</p>
            <small>🕒 Reviewed on: ${formattedDate}</small>
        `;

        reviewsContainer.appendChild(reviewItem);
    });
}

function setupReviews(movies) {
    const movieSelect = document.getElementById("movie-select");
    const submitButton = document.getElementById("submit-review");
    let selectedRating = 0; 

    movies.forEach(movie => {
        const option = document.createElement("option");
        option.value = movie.title;
        option.textContent = movie.title;
        movieSelect.appendChild(option);
    });

    displayReviews(movieSelect.value);

    movieSelect.addEventListener("change", function () {
        displayReviews(movieSelect.value);
    });

    document.querySelectorAll(".star").forEach((star, index) => {
        star.addEventListener("mouseover", () => highlightStars(index + 1));
        star.addEventListener("click", () => selectedRating = index + 1);
        star.addEventListener("mouseout", () => highlightStars(selectedRating));
    });

    function highlightStars(rating) {
        document.querySelectorAll(".star").forEach((star, index) => {
            star.classList.toggle("selected", index < rating);
        });
    }

    submitButton.addEventListener("click", function () {
        const selectedMovie = movieSelect.value;
        const reviewerName = document.getElementById("reviewer-name").value.trim();
        const reviewText = document.getElementById("review-text").value.trim();

        if (!selectedMovie || !reviewerName || !reviewText || selectedRating === 0) {
            alert("Please fill in all fields and select a rating.");
            return;
        }

        const newReview = { 
            name: reviewerName, 
            rating: selectedRating, 
            text: reviewText, 
            timestamp: new Date().toISOString()  
        };

        let reviews = JSON.parse(localStorage.getItem(selectedMovie)) || [];
        reviews.push(newReview);
        localStorage.setItem(selectedMovie, JSON.stringify(reviews));

        alert("Review submitted successfully!");
        document.getElementById("reviewer-name").value = "";
        document.getElementById("review-text").value = "";
        selectedRating = 0; 
        highlightStars(0); 

        displayReviews(selectedMovie);
    });
}

document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("mobile-menu").addEventListener("click", function () {
        document.querySelector(".nav-list").classList.toggle("active");
    });
});
