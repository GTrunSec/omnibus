# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs }:
{
  default = {
    output = "cog.toml";
    commands = [ { package = inputs.nixpkgs.cocogitto; } ];
    data = {
      tag_prefix = "v";
      branch_whitelist = [
        "main"
        "release/**"
      ];
      ignore_merge_commits = true;
      pre_bump_hooks = [
        "echo {{version}} > ./VERSION"
        ''
          branch="$(echo "release/{{version}}" | sed 's/\.[^.]*$//')"
          if [ `git rev-parse --verify $branch 2>/dev/null` ]
          then
            git switch -m "$branch" || exit 1
            git merge main
          else
            git switch -c "$branch" || exit 1
          fi
        ''
      ];
      post_bump_hooks = [
        ''
          branch="$(echo "release/{{version}}" | sed 's/\.[^.]*$//')"
          git push --set-upstream origin "$branch"
          git push origin v{{version}}

          git switch main
          git merge "$branch" --no-commit --no-ff
          echo {{version+minor-dev}} > ./VERSION
          git add VERSION
          git commit -m "chore: sync with release"
          git push origin main
        ''
        "cog -q changelog --at v{{version}}"
      ];
      changelog = {
        path = "CHANGELOG.md";
        template = "remote";
        remote = "github.com";
      };
    };
  };
}
