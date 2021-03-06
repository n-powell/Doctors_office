class Patient
  attr_accessor(:name, :birthdate, :id, :doc_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @id = attributes[:id]
    @doc_id = attributes[:doc_id]
  end

  define_singleton_method(:all) do
    returned_patient = DB.exec("SELECT * FROM patients;")
    patients = []
      returned_patient.each() do |patient|
        name = patient.fetch("name")
        birthdate = patient.fetch("birthdate")
        id = patient.fetch("id").to_i()
        doc_id = patient.fetch("doc_id").to_i()
        patients.push(Patient.new({:name => name, :birthdate => birthdate, :id => id, :doc_id => doc_id}))
        end
      patients
    end

  define_method(:save) do
    result = DB.exec("INSERT INTO patients (name, birthdate) VALUES ('#{@name}', '#{@birthdate}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patient|
    self.name().==(another_patient.name())
  end



end
