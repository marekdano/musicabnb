class LocationPolicy < ApplicationPolicy

  def new?
    @member
  end

  def create?
    @member
  end

  def update?
    @member && @record.member == @member
  end

  def edit?
    @member && @record.member == @member
  end

  def destroy?
    @member && @record.member == @member
  end

  def calendar?
    @member && @record.member == @member
  end

  def add_available_dates?
     @member && @record.member == @member
  end

  def add_images?
     @member && @record.member == @member
  end
  
end
