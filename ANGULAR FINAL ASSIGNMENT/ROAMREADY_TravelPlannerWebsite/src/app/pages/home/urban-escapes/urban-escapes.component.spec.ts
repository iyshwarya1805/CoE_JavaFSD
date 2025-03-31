import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UrbanEscapesComponent } from './urban-escapes.component';

describe('UrbanEscapesComponent', () => {
  let component: UrbanEscapesComponent;
  let fixture: ComponentFixture<UrbanEscapesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [UrbanEscapesComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(UrbanEscapesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
