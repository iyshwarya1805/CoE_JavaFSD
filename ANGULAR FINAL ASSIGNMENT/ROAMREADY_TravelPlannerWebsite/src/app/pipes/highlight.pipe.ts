import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'highlight',
  standalone: true // ✅ Allows standalone import
})
export class HighlightPipe implements PipeTransform {
  transform(value: string, keyword: string): string {
    if (!keyword || !value) return value;
    const regex = new RegExp(`(${keyword})`, 'gi');
    return value.replace(regex, `<span style="color: red; font-weight: bold;">$1</span>`);
  }
}
