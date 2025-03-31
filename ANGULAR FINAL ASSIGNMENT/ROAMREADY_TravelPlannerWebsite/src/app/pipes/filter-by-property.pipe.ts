import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'filterByProperty'
})
export class FilterByPropertyPipe implements PipeTransform {
  transform(items: any[], property: string, searchTerm: string): any[] {
    if (!items || !property || !searchTerm) return items;
    return items.filter(item => 
      item[property] && item[property].toLowerCase().includes(searchTerm.toLowerCase())
    );
  }
}
