import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common'; 

@Component({
  selector: 'app-menu-bar',
  templateUrl: './menu-bar.component.html',
  styleUrls: ['./menu-bar.component.css'], // ✅ Include the CSS file
  standalone: true,
  imports: [RouterModule, CommonModule] // ✅ Import CommonModule for basic directives
})
export class MenuBarComponent { }
