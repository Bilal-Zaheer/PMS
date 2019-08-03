# frozen_string_literal: true

class ProjectsBaseController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
    find_project
  end

  def create
    @project = Project.new(project_params.except(:employees))
    @empls = project_params[:employees]
    @empls.shift
    @empls.each do |a|
      e = Employee.find(a)
      @project.employees << e
    end
    @project.creater_id = current_user.id
    if @project.save
      redirect_to my_project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def assigned_employees
    find_project
  end

  def edit
    find_project
  end

  def update
    find_project
    @empls = project_params[:employees]
    @abc = project_params.except(:employees)
    @empls.shift
    @project.employees.delete(@project.employees)
    @empls.each do |a|
      e = Employee.find(a)
      @project.employees << e
    end
    @abc[:employees] = @project.employees
    puts @abc
    if @project.update(@abc)
      redirect_to my_project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    find_project
    @project.destroy
    redirect_to my_project, notice: 'Project was successfully destroyed.'
  end

  private

  def find_project
    @project = Project.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @project
  end

  def project_params
    params.require(:project).permit(:title, :description, :hours_spent, :amount, :client_id, :manager_id, employees: [])
  end
end