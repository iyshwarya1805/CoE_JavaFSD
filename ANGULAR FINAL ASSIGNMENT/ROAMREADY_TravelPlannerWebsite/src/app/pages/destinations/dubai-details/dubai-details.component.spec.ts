import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DubaiDetailsComponent } from './dubai-details.component';

describe('DubaiDetailsComponent', () => {
  let component: DubaiDetailsComponent;
  let fixture: ComponentFixture<DubaiDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [DubaiDetailsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DubaiDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
