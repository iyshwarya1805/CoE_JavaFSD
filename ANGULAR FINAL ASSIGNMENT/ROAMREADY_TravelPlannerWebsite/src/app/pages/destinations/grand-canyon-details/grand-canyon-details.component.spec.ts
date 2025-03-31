import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GrandCanyonDetailsComponent } from './grand-canyon-details.component';

describe('GrandCanyonDetailsComponent', () => {
  let component: GrandCanyonDetailsComponent;
  let fixture: ComponentFixture<GrandCanyonDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [GrandCanyonDetailsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(GrandCanyonDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
