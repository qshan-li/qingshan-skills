# Release Action Status Separation

## Trigger

Implementation verification is Ready, but the requested PR create or push fails
with authentication error or remote rejection.

## Expected route

/verify reports readiness status Ready and release action status failed, without
claiming the implementation is unverified solely because the release action failed.

## Shortcut risk

The agent collapses push/auth failure into implementation verification failure,
or claims shipped when only readiness passed.

## Pass condition

Readiness status and release action status are reported separately. Auth,
credentials, merge conflict, remote rejection, and handoff refusal are
release-action failures when readiness already passed.

## Required signals

- [release-action-status-separate] Readiness status and release action status are both reported.
- [release-action-failure-not-impl-failure] Release-action failure is not treated as implementation verification failure when readiness already passed.
