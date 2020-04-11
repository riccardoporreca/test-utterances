create_utterances_issues <- function(meta, owner, repo, site) {
  # utils ----
  gh <- function(subpath, ..., method = "GET") {
    gh::gh(
      sprintf("/repos/:owner/:repo/%s", subpath),
      owner = owner,
      repo = repo,
      .method = method, ...
    )
  }
  issue_title <- function(page_name) {
    sprintf("%s/%s", basename(site), page_name)
  }
  issue_body <- function(page_name) {
    paste0(
      sprintf("# %s", meta[[page_name]]$title), "\n", "\n",
      sprintf("%s/%s.html", site, page_name)
    )
  }
  create_utterances_issue <- function(page_name) {
    message(page_name, ": ", meta[[page_name]]$title)
    # create the issue
    issue <- gh(
      method = "POST",
      "issues",
      title = issue_title(page_name),
      body = issue_body(page_name),
      labels = list(":+1:")
    )
    message("> issue #", issue$number)
    # create the initial standard
    comment <- gh(
      method = "POST",
      sprintf("issues/%d/comments", issue$number),
      body = paste0(
        "Vote for this contribution by giving it a :+1:!\n",
        "_Please avoid using comments or other reactions_"
      )
    )
    message("> comment id: ", comment$id)
    # create the initial like
    reaction <- gh(
      method = "POST",
      sprintf("issues/comments/%d/reactions", comment$id),
      content = "+1",
      .accept = "application/vnd.github.squirrel-girl-preview+json" # Beta feature!
    )
    message("> reaction id: ", reaction$id)

    invisible(list(
      issue = issue,
      comment = comment,
      reaction = reaction
    ))
  }

  existing_titles <- vapply(
    gh("issues"), FUN.VALUE = "",
    `[[`, "title"
  )

  missing_meta <- meta[!issue_title(names(meta)) %in% existing_titles]

  created <- sapply(
    names(missing_meta), create_utterances_issue,
    simplify = FALSE
  )

  invisible(created)
}
