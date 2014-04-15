class Admin::PipelinesSnippetController < AdminController
  before_filter :set_tab_name
  before_filter :load_config_for_edit, :only => [:edit]

  CLONER = Cloner.new

  def show
    set_group_data
    render_localized_operation_result @result and return unless @result.is_successful
  end

  def edit
    set_group_data
    render_localized_operation_result @result and return unless @result.is_successful
    @config_md5 = @cruise_config.getMd5()
  end

  def index
    @modifiable_groups = security_service.modifiableGroupsForUser(current_user)
    redirect_to pipelines_snippet_show_path(@modifiable_groups.first)
  end

  def update
    result = HttpLocalizedOperationResult.new
    cruise_config_repsonse = pipeline_configs_service.updateXml(params[:group_name], params[:group_xml], params[:config_md5], current_user, result)
    pipeline_configs = cruise_config_repsonse.getConfigElement()
    validity = cruise_config_repsonse.getValidity()
    @errors = [validity.errorMessage()] if (validity.isMergeConflict() || validity.isPostValidationError())
    localizer = Spring.bean('localizer')

    redirect_to pipelines_snippet_show_path(pipeline_configs.get_group, :fm => set_flash_message(result.message(localizer),'success')) and return if result.is_successful()

    flash.now[:error] = result.message(localizer)
    @modifiable_groups = security_service.modifiableGroupsForUser(current_user)
    @group_name = params[:group_name]
    @group_as_xml = params[:group_xml]
    @config_md5 = params[:config_md5]
    render :edit
  end

  private

  def set_group_data
    @modifiable_groups = security_service.modifiableGroupsForUser(current_user)
    @result = set_group_xml params[:group_name]
    @group_name = params[:group_name]
  end

  def set_group_xml group_name
    result = HttpLocalizedOperationResult.new
    @group_as_xml = pipeline_configs_service.getXml(group_name, current_user, result)
    return result
  end

  def set_tab_name
    @tab_name = "pipelines-snippet"
  end

  def load_config_for_edit
    assert_load(:cruise_config, cruise_config_service.getConfigForEditing())
  end
end