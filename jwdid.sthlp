{smcl}
{* *!version 0.1 develop by Fernando Rios-Avila, help file written by Wenli Wenddy 8/01/2022}{...}
{viewerjumpto "Syntax" "jwdid##syntax"}{...}
{viewerjumpto "Description" "jwdid##description"}{...}
{viewerjumpto "Options" "jwdid##options"}{...}
{viewerjumpto "Examples" "jwdid##examples"}{...}
{viewerjumpto "Stored results" "jwdid##stored_results"}{...}
{viewerjumpto "References" "jwdid##references"}{...}
{viewerjumpto "Authors" "jwdid##authors"}{...}

{title:Tittle}

{p 4 8}{cmd:jwdid} {hline 2} Estimation and Inference for Two Way Mundlak models.{p_end}

{marker syntax}{...}
{title:Syntax}

{p 4 8}{cmd:jwdid}
{depvar} [{it:if}] [{it:in}] {weight},
{opt i:var}({it:varname}) 
{opt t:var}({it:varname})
{opt g:var}({it:varname})
[{it:notyet}]

{marker description}{...}
{title:Description}

{p 4 8}{cmd:jwdid} implements estimation and inference procedures for Two Way Mundlak model  according to {browse "https://economics.princeton.edu/wp-content/uploads/2021/08/two_way_mundlak-Wooldridge.pdf":Wooldridge(2021)'s method}. After reading his paper, and the dofiles, Fernando Rios-Avila put together a small script that implements his approach to develop the command, again no covariates yet.This command applies the twowayFE method. It is not yet the Mundlack approach he adovocates.

{p 8 8} Companion command is: {help jwdid_estat} for a set of utilities to get the Standard Aggregations.

{marker options}{...}
{title:Options}

{synoptset 20 tabbed}{...}

{syntab:{bf: Model Specification}}
{synopthdr}
{synoptline}
{synopt :{opt depvar}} Declares the dependent variable or outcome of interest. {p_end}
{synopt:{opt i:var(varname)}} Variable used as panel identifier. e.g., {it:province}. When declared, the model assumes the data 
has a panel structure, and will apply panel estimators. When no variable is declared the command assumes data are
 repeated crosssection (RC), and applies RC estimators. {p_end}
 
{synopt:{opt t:var(varname)}} Variable to identify time. e.g., {it:year}. Periods do not need to be consecutive, but
the variable is expected to be strictly positive, with regular gaps. {p_end}

{synopt:{opt g:var(varname)}} Variable identifying treatment groups or cohorts. Groups that are never treated should be coded as Zero. 
Any positive value indicates which year a group was initially treated. And once a group is treated, the underlying assumption
is that it always remains treated. {p_end}

{synopt:} e.g., 0 Never treated, 10 treat at t=10, 20 treated at time 20, 25 treated at time 25. {p_end}

{synopt:} If there are any groups treated before the first available period in the sample, those observations are 
considered always treated, and are excluded from the sample. {p_end}

{synopt:} For every cohort in {it:gvar} there should be a period in {it:time} otherwise, the command will produce an error. {p_end}

{synopt:} When using panel data, observations cannot change cohort across time. {p_end}

{synopt :{opt notyet}} specifies notyet treated group.{p_end}
{synoptline}


{marker post_estimation}{...}
{title:Post Estimaton}

{pstd}
{cmd: jwdid} offers one post estimation utilities. See {help jwdid_estat} for more details.
{p_end}

{phang}{cmd: est_estat} simply calls on {help margins}, and estimates the different aggregations over specific groups.
{p_end}

{phang}{cmd: estat simple} 
{p_end}

{phang}{cmd: estat calendar} 
{p_end}

{phang}{cmd: estat group} 
{p_end}

{phang}{cmd: estat event} 
{p_end}

{marker examples}{...}
{title:Examples}

{phang}
{stata "use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear"}

{pstd}You need to add an Individual fixed effect, a year fixed effect and the cohort variable gvar. This version Only accepts the outcome variable. {p_end}

{phang}
{stata jwdid  lemp , i(countyreal) t(year) gvar(first_treat)}

{pstd}Post Estimaton: want to get some aggregation, like Simple, Calendar and group, or Event.  {p_end}
{phang}
{stata estat simple}

{phang}
{stata estat calendar}

{phang}
{stata estat group}

{phang}
{stata estat event}


{marker authors}{...}
{title:Authors}


{pstd}
Fernando Rios-Avila{break}
Levy Economics Institute of Bard College{break}
Annandale-on-Hudson, NY{break}
friosavi@levy.org

the help file written by Wenli Wenddy Xu 8/01/2022

