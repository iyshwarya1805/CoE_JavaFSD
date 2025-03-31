import { bootstrapApplication } from '@angular/platform-browser';
import { AppComponent } from './app/app.component';
import { provideRouter } from '@angular/router';
import { routes } from './app/app-routing.module';
import { provideHttpClient } from '@angular/common/http';  // ✅ Import this

bootstrapApplication(AppComponent, {
  providers: [
    provideRouter(routes),
    provideHttpClient()  // ✅ Fix: Provide HttpClient here
  ]
}).catch(err => console.error(err));
