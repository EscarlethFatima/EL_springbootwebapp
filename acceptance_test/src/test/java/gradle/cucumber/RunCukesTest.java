package gradle.cucumber;

import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;
import cucumber.api.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(plugin = { "pretty",
"html:build/reports/cucumber","json:build/test-results/testreports.json"})
public class RunCukesTest {
}
