import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BeachGetawaysComponent } from './beach-getaways.component';

describe('BeachGetawaysComponent', () => {
  let component: BeachGetawaysComponent;
  let fixture: ComponentFixture<BeachGetawaysComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [BeachGetawaysComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BeachGetawaysComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
