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
  previewImage: string | null = null;
  fileName = '';

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

  onFileSelected(event: Event) {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (file) {
      this.fileName = file.name;
      const reader = new FileReader();
      reader.onload = () => {
        this.previewImage = reader.result as string;
      };
      reader.readAsDataURL(file);
    }
  }

  removeImage() {
    this.previewImage = null;
    this.fileName = '';
  }

  submitBlogForm() {
    // Hier implementierst du die Logik zum Senden des Formulars an den Server
    console.log('Blog erstellt:', this.blog);
  }
}
