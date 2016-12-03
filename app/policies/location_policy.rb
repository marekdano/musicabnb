class LocationPolicy < ApplicationPolicy

  def new?
    @member
  end

  def create?
    @member
  end

  def update?
    @member && @member.location == @record
  end

  def edit?
    @member && @member.location == @record
  end

  def destroy?
    @member && @member.location == @record
  end
  
end
