namespace :db do
  desc "Export all database tables to CSV files"
  task export_to_csv: :environment do
    require 'csv'

    # Répertoire pour stocker les fichiers CSV
    export_dir = "db/csv_exports"
    FileUtils.mkdir_p(export_dir) # Crée le dossier s'il n'existe pas

    # Parcourt toutes les tables de la base de données
    ActiveRecord::Base.connection.tables.each do |table_name|
      begin
        # Essaie de convertir le nom de la table en modèle
        model = table_name.singularize.camelize.constantize

        # Crée un fichier CSV pour la table
        file_path = "#{export_dir}/#{table_name}.csv"
        CSV.open(file_path, "w") do |csv|
          # Ajoute les en-têtes
          csv << model.column_names

          # Ajoute les données
          model.find_each do |record|
            csv << record.attributes.values
          end
        end

        puts "✅ Exported #{table_name} to #{file_path}"
      rescue NameError
        puts "⚠️  Skipping #{table_name} (no corresponding model)"
      end
    end

    puts "✅ All tables exported to #{export_dir}"
  end
end
