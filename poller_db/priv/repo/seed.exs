alias PollerDb.{Districts, Candidates, Questions}
alias PollerDb.Repo
Repo.delete_all(PollerDb.Districts.District)
{:ok, district} = Districts.cretae_district(%{name: "Bikini Bottom"})

{:ok, question} =
  Questions.cretae_question(%{title: "Bikini Bottom Commons", district_id: district.id})

_candidate =
  Candidates.cretae_candidate(%{
    name: "Patrick Star",
    party: 1,
    slogan: "You cannot stop the unstoppable",
    question_id: question.id
  })
