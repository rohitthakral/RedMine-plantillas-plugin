module ProjectsControllerPatch
    def self.included(base)
    	base.send(:include, InstanceMethods)
	    base.class_eval do
	      # alias_method_chain :settings, :template
        alias_method :settings_without_template, :settings
        alias_method :settings, :settings_with_template
	    end
    end
module InstanceMethods
  def settings_with_template 
    @issue_custom_fields = IssueCustomField.all.order("#{CustomField.table_name}.position")
    @issue_category ||= IssueCategory.new
    @member ||= @project.members.new
    @trackers = Tracker.all
    @versions = Version.all
    @wiki ||= @project.wiki
    @project_id = @project.id
    @templates = WikiTemplates.where("project_id = ? " , @project_id)
  end
end
end
