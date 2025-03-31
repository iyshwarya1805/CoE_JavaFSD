import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'tripFormatter',
  standalone: true // ✅ Standalone pipe
})
export class TripFormatterPipe implements PipeTransform {
  transform(value: string): string {
    return value ? value.toUpperCase() : ''; // Example: Convert to uppercase
  }
}
