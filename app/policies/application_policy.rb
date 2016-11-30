class ApplicationPolicy
  attr_reader :current_member, :record

  def initialize(current_member, record)
    @member = current_member
    @record = record
  end

  def scope
    Pundit.policy_scope!(member, record.class)
  end

  class Scope
    attr_reader :member, :scope

    def initialize(member, scope)
      @member = member
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
