library(tidyverse)
library(gt)
library(gtExtras)
library(rvest)
library(JuliaCall)


# 1. Julia ----------------------------------------------------------------

julia_setup(JULIA_HOME="C:/Users/statkclee/AppData/Local/Programs/Julia-1.10.1/bin")

set.seed(1014)

# https://github.com/rstudio/rmarkdown/issues/2420

# quarto fancy-text extentions
# if (knitr::is_html_output()){
#   latexString <- "$\\LaTeX$"
# } else {
#   latexString<- r"(\LaTeX)"
# }


# 2. fonts ----------------------------------------------------------------

library(sysfonts)
library(showtext)

extrafont::loadfonts(quiet = TRUE)

showtext_auto(enable = TRUE)

# 3. 코딩 -------------------------------------------------------------------


knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  # cache = TRUE,
  fig.retina = 2,
  fig.width = 6,
  fig.asp = 2/3,
  fig.show = "hold"
)

options(
  dplyr.print_min = 6,
  dplyr.print_max = 6,
  pillar.max_footer_lines = 2,
  pillar.min_chars = 15,
  stringr.view_n = 6,
  # Temporarily deactivate cli output for quarto
  cli.num_colors = 0,
  cli.hyperlink = FALSE,
  pillar.bold = TRUE,
  width = 77 # 80 - 3 for #> comment
)

# 1. ggplot 그래프 ------------------------
extrafont::loadfonts("win")

## 테마 (글꼴) -----------------------------
theme_korean <- function() {

  # ggthemes::theme_tufte() +
  ggplot2::theme_minimal() +

    ggplot2::theme(
      plot.title     = ggplot2::element_text(family = "NanumSquare", size = 18, face = "bold"),
      plot.subtitle  = ggplot2::element_text(family = "MaruBuri", size = 13),
      axis.title.x   = ggplot2::element_text(family = "MaruBuri"),
      axis.title.y   = ggplot2::element_text(family = "MaruBuri"),
      axis.text.x    = ggplot2::element_text(family = "MaruBuri", size = 11),
      axis.text.y    = ggplot2::element_text(family = "MaruBuri", size = 11),
      legend.title   = ggplot2::element_text(family = "MaruBuri", size=13),
      plot.caption   = ggplot2::element_text(family = "NanumSquare", color = "gray20")
    )
}


ggplot2::theme_set(theme_korean())

# 2. gt 표 ------------------------

gt_theme_hangul <- function(gt_tbl) {

  # Grab number of rows of data from gt object
  n_rows <- nrow(gt_tbl$`_data`)

  gt_tbl |>
    gt_theme_538() |>
    tab_options(
      # column_labels.background.color = '#1E61B0', # R logo 파란색
      table.font.names ="NanumSquare",
      heading.title.font.size = px(26),
      heading.subtitle.font.size = px(16),
      heading.background.color = "transparent",
      column_labels.font.weight = 'bold',
      table_body.hlines.width = px(0),
      data_row.padding = px(6),
      heading.align = 'center',
      stub.background.color = "#ffffff",
      stub.font.weight = "bold",
      source_notes.font.size = px(10),
      row.striping.include_table_body = FALSE
    ) |>
    cols_align( align = "center", columns = where(is.numeric)) |>
    cols_align( align = "auto", columns = where(is.character)) |>
    ## 글꼴 달리 적용
    tab_style(
      style = cell_text(
        font = "MaruBuri",
        weight = 'bold'
      ),
      locations = cells_title(groups = 'subtitle')
    ) |>
    tab_style(
      style = cell_text(
        font = "MaruBuri",
        weight = 'bold'
      ),
      locations = cells_body()
    ) |>
    tab_style(
      style = cell_text(
        font = "MaruBuri",
        weight = 'bold'
      ),
      locations = cells_column_labels()
    ) |>
    tab_style(
      style = cell_text(
        font = "MaruBuri",
      ),
      locations = cells_source_notes()
    ) |>
    tab_style(
      style = cell_fill(color = 'grey90'),
      locations = cells_body(rows = seq(1, n_rows, 2))
    )
}
