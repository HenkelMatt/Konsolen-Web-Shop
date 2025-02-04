import { Component } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './create-artikel.component.html',
  styleUrls: ['./create-artikel.component.css']
})
export class CreateArtikelComponent {
  blog = { title: '', content: '' };
  categories: string[] = [];
  newCategory = '';
  categoriesJson = '';
  images: { file: File, preview: string }[] = [];
  contextMenu = { visible: false, x: 0, y: 0, imageIndex: -1 };

  addCategory() {
    if (this.newCategory.trim()) {
      this.categories.push(this.newCategory.trim());
      this.newCategory = '';
      this.updateCategoriesJson();
    }
  }

  removeCategory(index: number) {
    this.categories.splice(index, 1);
    this.updateCategoriesJson();
  }

  updateCategoriesJson() {
    this.categoriesJson = JSON.stringify(this.categories);
  }

  onFilesSelected(event: Event) {
    const files = (event.target as HTMLInputElement).files;
    if (files) {
      Array.from(files).forEach(file => {
        const reader = new FileReader();
        reader.onload = () => {
          this.images.push({
            file,
            preview: reader.result as string
          });
        };
        reader.readAsDataURL(file);
      });
    }
  }

  onDragStart(event: DragEvent, index: number) {
    event.dataTransfer?.setData("imageIndex", index.toString());
  }

  onDragOver(event: DragEvent) {
    event.preventDefault();
  }

  onDrop(event: DragEvent, targetIndex: number) {
    event.preventDefault();
    const draggedIndex = Number(event.dataTransfer?.getData("imageIndex"));
    if (draggedIndex !== targetIndex) {
      const draggedImage = this.images[draggedIndex];
      this.images.splice(draggedIndex, 1);
      this.images.splice(targetIndex, 0, draggedImage);
    }
  }

  onRightClick(event: MouseEvent, index: number) {
    event.preventDefault();
    this.contextMenu = {
      visible: true,
      x: event.clientX,
      y: event.clientY,
      imageIndex: index
    };
  }

  removeImage() {
    if (this.contextMenu.imageIndex > -1) {
      this.images.splice(this.contextMenu.imageIndex, 1);
      this.contextMenu.visible = false; // Kontextmenü schließen
    }
  }

  submitBlogForm() {
    console.log('Blog erstellt:', this.blog);
  }
}
