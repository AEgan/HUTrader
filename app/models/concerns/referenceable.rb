module Referenceable extend ActiveSupport::Concern

  def reference_exists_in_system(class_name)
    klass = Object.const_get(class_name.to_s)
    foreign_key = "#{class_name.downcase}_id"
    record = klass.find_by_id(self.send(foreign_key))
    if record.nil?
      self.errors.add(foreign_key, "does not exist in the system")
      return false
    end
    true
  end
end
