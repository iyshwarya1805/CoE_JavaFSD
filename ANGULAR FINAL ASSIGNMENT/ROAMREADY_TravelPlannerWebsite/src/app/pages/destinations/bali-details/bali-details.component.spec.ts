import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BaliDetailsComponent } from './bali-details.component';

describe('BaliDetailsComponent', () => {
  let component: BaliDetailsComponent;
  let fixture: ComponentFixture<BaliDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [BaliDetailsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BaliDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
