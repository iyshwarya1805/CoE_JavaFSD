import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DestinationService {
  destinations = [
    { 
      name: 'Bali Paradise', 
      image: 'http://localhost:8090/bali.jpg', 
      addedDate: new Date(), 
      price: 1500, 
      description: 'Bali offers a serene and vibrant mix of culture, beach, and mountains.' 
    },
    { 
      name: 'Swiss Alps', 
      image: 'http://localhost:8090/swiss.jpg', 
      addedDate: new Date(), 
      price: 2000, 
      description: 'The Swiss Alps are famous for their breathtaking scenery and outdoor adventures.' 
    },
    { 
      name: 'Grand Canyon', 
      image: 'http://localhost:8090/grand.jpg', 
      addedDate: new Date(), 
      price: 1200, 
      description: 'Explore the vast and stunning Grand Canyon, a natural wonder of the world.' 
    },
    { 
      name: 'Machu Picchu', 
      image: 'http://localhost:8090/machu.jpg', 
      addedDate: new Date(), 
      price: 2500, 
      description: 'Discover the ancient Inca city of Machu Picchu nestled in the Peruvian Andes.' 
    },
    { 
      name: 'Paris City', 
      image: 'http://localhost:8090/paris.jpg', 
      addedDate: new Date(), 
      price: 3000, 
      description: 'Paris, the City of Lights, known for its art, history, and iconic landmarks.' 
    },
    { 
      name: 'Santorini', 
      image: 'http://localhost:8090/santorini.jpg', 
      addedDate: new Date(), 
      price: 2200, 
      description: 'Santorini offers stunning sunsets, crystal-clear waters, and volcanic beaches.' 
    },
    { 
      name: 'Tokyo Skytree', 
      image: 'http://localhost:8090/tokyo.jpg', 
      addedDate: new Date(), 
      price: 2700, 
      description: 'A visit to the Tokyo Skytree offers unparalleled views of the bustling city below.' 
    },
    { 
      name: 'Great Barrier Reef', 
      image: 'http://localhost:8090/reef.jpg', 
      addedDate: new Date(), 
      price: 1800, 
      description: 'Dive into the vibrant underwater world of the Great Barrier Reef in Australia.' 
    },
    { 
      name: 'Rome Colosseum', 
      image: 'http://localhost:8090/rome.jpg', 
      addedDate: new Date(), 
      price: 1600, 
      description: 'Rome’s Colosseum offers a journey back in time to the grandeur of Ancient Rome.' 
    },
    { 
      name: 'Dubai Burj Khalifa', 
      image: 'http://localhost:8090/burj.jpg', 
      addedDate: new Date(), 
      price: 3500, 
      description: 'Experience luxury and stunning city views from the world’s tallest building, Burj Khalifa.' 
    }
  ];

  getDestinations(): Observable<any[]> {
    return of(this.destinations);
  }
}


  
