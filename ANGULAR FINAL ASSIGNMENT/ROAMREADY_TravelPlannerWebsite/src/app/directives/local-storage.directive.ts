import { Directive, HostListener, Input } from '@angular/core';

@Directive({ selector: '[appLocalStorage]' })
export class LocalStorageDirective {
  @Input('appLocalStorage') key!: string;

  @HostListener('input', ['$event.target.value'])
  onInput(value: string) {
    if (this.key) {
      localStorage.setItem(this.key, value);
    }
  }
}