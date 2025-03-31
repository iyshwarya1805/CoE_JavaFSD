import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MountainAdventuresComponent } from './mountain-adventures.component';

describe('MountainAdventuresComponent', () => {
  let component: MountainAdventuresComponent;
  let fixture: ComponentFixture<MountainAdventuresComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [MountainAdventuresComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MountainAdventuresComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
