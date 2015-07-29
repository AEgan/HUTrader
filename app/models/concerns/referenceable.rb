module Referenceable extend ActiveSupport::Concern

  def reference_exists_in_system(klass)
    class_name = klass.to_s
    foreign_key = "#{class_name.downcase}_id"
    record = klass.find_by_id(send(foreign_key))
    if record.nil?
      errors.add(foreign_key, "does not exist in the system")
    end
  end
end
