namespace :categories do
  desc "Add default categories to db"
  task :default_categories => :environment do
    if !Category.find_by(name: "Autobiografico")
      Category.create(name: "Autobiografico")
      Category.create(name: "Avventura")
      Category.create(name: "Comico")
      Category.create(name: "Drammatico")
      Category.create(name: "Fantascientifico")
      Category.create(name: "Fantasy")
      Category.create(name: "Fiaba")
      Category.create(name: "Filosofico")
      Category.create(name: "Giallo")
      Category.create(name: "Hard")
      Category.create(name: "Horror")
      Category.create(name: "Paranormale")
      Category.create(name: "Politico")
      Category.create(name: "Poliziesco")
      Category.create(name: "Psicologico")
      Category.create(name: "Romantico")
      Category.create(name: "Satirico")
      Category.create(name: "Sogni")
      Category.create(name: "Storico")
      Category.create(name: "Teatro")
      Category.create(name: "Thriller")
    end
  end  

  desc "Run all tasks"
  task :load => :default_categories
end
