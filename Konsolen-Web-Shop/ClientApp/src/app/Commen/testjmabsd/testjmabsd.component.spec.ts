import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TestjmabsdComponent } from './testjmabsd.component';

describe('TestjmabsdComponent', () => {
  let component: TestjmabsdComponent;
  let fixture: ComponentFixture<TestjmabsdComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TestjmabsdComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TestjmabsdComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
