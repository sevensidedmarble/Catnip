defmodule CatWeb.ViewHelpers do
  def pagination_opts do
    [
      ellipsis_attrs: [class: "ellipsis"],
      ellipsis_content: "...",
      next_link_attrs: [class: "next"],
      # next_link_content: next_icon(),
      page_links: {:ellipsis, 7},
      pagination_link_aria_label: &"#{&1}ページ目へ",
      previous_link_attrs: [class: "prev"],
      # previous_link_content: previous_icon()
    ]
  end
end
